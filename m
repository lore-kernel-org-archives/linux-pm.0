From: yu chen <yu.chen.surf@gmail.com>
Subject: Re: pause to allow user to read final screen before poweroff
Date: Tue, 1 Mar 2016 13:53:39 +0800
Message-ID: <CADjb_WScj4Hpd6Ej+hxHGKiAiFkWfvMS2zGmquBDsQn54AC_JA@mail.gmail.com>
References: <bug-112111-12294@https.bugzilla.kernel.org/>
	<878u224uuq.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35342 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbcCAFxk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 00:53:40 -0500
Received: by mail-wm0-f53.google.com with SMTP id l68so19847201wml.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 21:53:40 -0800 (PST)
In-Reply-To: <878u224uuq.fsf_-_@jidanni.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, jidanni@jidanni.org

On Tue, Mar 1, 2016 at 1:42 PM, Dan Jacobson <jidanni@jidanni.org> wrote:
> How can the user read the final screen before powerdown? I have a proposal:
> https://bugzilla.kernel.org/show_bug.cgi?id=112111
>
> b> --- Comment #1 from Aaron Lu <aaron.lu@intel.com> ---
> b> bugzilla is not the right place for such discussion, please send your proposal
> b> to linux-pm@vger.kernel.org mailing list.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Sometimes people use serialport,etc, why do you want
to record the last message for poweroff? I know there
is similar scenario for panic of panic_timeout.
