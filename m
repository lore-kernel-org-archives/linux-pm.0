Return-Path: <SRS0=ABut=42=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E2AC10F27
	for <linux-pm@archiver.kernel.org>; Mon,  9 Mar 2020 18:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340E621927
	for <linux-pm@archiver.kernel.org>; Mon,  9 Mar 2020 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583777517;
	bh=g4rrfzjCL4hI6s6dopZcQt/VCDFZg5ds7WQUwVk+JNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v9dgIeH4f23dgAahrGifMiH7+LOQcOxBTAwMjCaHy1sOeYOFD8cP9+XLqGQvyAwn+
	 h2rk6SRjLOIJ1CQYBEewQOX1+vq0Ho4uoCaH5v+Yt5uINOU3Bhn7X5kVkEA2evySM+
	 Hzlep75YoNwD4ajqbT5B0QBXmIQqBWW097yV2OvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCISL4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgCISL4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 14:11:56 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71BE20578;
        Mon,  9 Mar 2020 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583777516;
        bh=g4rrfzjCL4hI6s6dopZcQt/VCDFZg5ds7WQUwVk+JNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brUnLUwvrCnMEr/yJII2YhYLe6aEfst7VS4X7H8UvrTWQGb82h1uCvWqFA5Gbh1HO
         zIng1d3UkVO+F7/YioYf50YJn0eFxsn5wRbLdaxddQzcJuOwXuKk6E2Wlrj2liubmM
         qJZdJCSs9gWk5mnh2e2JiR0NuZCZvMCfkSjyiztM=
Date:   Mon, 9 Mar 2020 11:11:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     syzbot <syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KMSAN: uninit-value in snapshot_compat_ioctl
Message-ID: <20200309181154.GB1073@sol.localdomain>
References: <000000000000938a57059f7cafe4@google.com>
 <20200307235437.GW15444@sol.localdomain>
 <20200308032434.GX15444@sol.localdomain>
 <CAG_fn=X8UkYx5=3ARUtW3+asc+3tEdeBg=1NKS9VzChSCp33Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X8UkYx5=3ARUtW3+asc+3tEdeBg=1NKS9VzChSCp33Yg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 09, 2020 at 12:53:28PM +0100, 'Alexander Potapenko' via syzkaller-bugs wrote:
> > > Looks like a KMSAN false positive?  As far as I can tell, the memory is being
> > > initialized by put_user() called under set_fs(KERNEL_DS).
> 
> Why? put_user() doesn't write to kernel memory, instead it copies a
> value to the userspace.
> That's why KMSAN performs kmsan_check_memory() on it.
> It would actually be better if KMSAN printed an kernel-infoleak warning instead.

When under set_fs(KERNEL_DS), the userspace access functions like put_user() and
copy_to_user() can write to kernel memory.  It's discouraged and people have
been trying to get rid of uses of set_fs(), but a lot still remain, since
sometimes it's useful to allow code to operate on both user and kernel memory.
A common example is kernel_read().

> 
> > Although, it also looks like the problematic code can just be removed, since
> > always sizeof(compat_loff_t) == sizeof(loff_t).  I'll send a patch to do that...
> 
> Thanks!
> 

- Eric
