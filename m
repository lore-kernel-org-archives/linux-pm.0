From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Getting rid of freezer for suspend [was Re: [fuse-devel] [PATCH]
 fuse: make fuse daemon frozen along with kernel threads]
Date: Thu, 14 Feb 2013 11:31:53 +0100
Message-ID: <CAJfpegvEGM9B3niQtfmH1OhLLRjaq6OiyJpKRe3g1wD_egzQLQ@mail.gmail.com>
References: <1360113112.17267.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
	<2964781.rPUOipNRNb@vostro.rjw.lan>
	<CAJfpegtNUr+AJXZcKmLEGBYqu20DVFwzg-OvOk_nS3fBS3wd=Q@mail.gmail.com>
	<1660768.prnx6s70rD@vostro.rjw.lan>
	<CAJfpegt2B3n-QNK_W7O2H0JVfS=4jcUOzV_+w8ELPq19RJPewQ@mail.gmail.com>
	<20130212104608.GA24042@amd.pavel.ucw.cz>
	<CAJfpegvdVfEFTU5haMMi94PD1iZ1XyCRjg0O9vDjDg1yyaM-yA@mail.gmail.com>
	<CAJfpegvV0zQ5Lftx=ELP0MAH1-7oY5HfT-CSYEaFUWJLmXoD7A@mail.gmail.com>
	<CAJfpegsFThkzv3uF60AMXO7Y-yEzU_20HeGyPra0O8Vk5OqCGQ@mail.gmail.com>
	<20130213201609.GA4296@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35522 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab3BNKb4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Feb 2013 05:31:56 -0500
Received: by mail-lb0-f179.google.com with SMTP id j14so1678046lbo.10
        for <linux-pm@vger.kernel.org>; Thu, 14 Feb 2013 02:31:54 -0800 (PST)
In-Reply-To: <20130213201609.GA4296@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Goswin von Brederlow <goswin-v-b@web.de>, Li Fei <fei.li@intel.com>, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, biao.wang@intel.com, linux-pm@vger.kernel.org, fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

On Wed, Feb 13, 2013 at 9:16 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2013-02-13 18:34:16, Miklos Szeredi wrote:
>> On Tue, Feb 12, 2013 at 2:17 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> > On Tue, Feb 12, 2013 at 2:13 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>> >> On Tue, Feb 12, 2013 at 11:46 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> >>
>> >>> (After all, with FUSE, filesystem clients are just doing IPC. In ideal
>> >>> world, that would be freezeable and killable with -9).
>>
>> Well, I thought this can be constrained to locks directly related to
>> the fuse filesystem itself, but it can't...  The reason is page
>
> And it looked so easy and nice...
>
>> faults.  Pretty much everyone and their brother uses get_user_pages*,
>> holding various locks (mmap_sem for sure but others as well).  A fuse
>> filesystem frozen during a page read will block those.
>
> Is it even valid for get_user_pages to be used on FUSE?

Disabling all mmap (which is what you question) would make fuse a
useless piece of toy.  So yes, definitely it's valid.

>
> What happens if fused tries to do some operation (it is userspace, it
> can do lot of operations) that needs one of those locks?

E.g. mmap_sem is taken for the process _accessing_ a vma for a fuse
filesystem. The server process better not do this (i.e. access the
filesystem it's serving) or deadlocking (*) is basically guaranteed.
That's nothing new.

The thing that makes this hard for freeze is that those locks
(mmap_sem, etc.) are only indirectly related to the fuse filesystem by
the _actions_ of a process (accessing mmaped fuse area).

Thanks,
Miklos

(*) userspace induced deadlocks in fuse are not hard deadlocks, they
can be forced open by "umount -f" or "echo >
/sys/fs/fuse/connections/$DEV/abort".
