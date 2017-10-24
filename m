From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v3] USB: Force disconnect Huawei 4G modem during suspend
Date: Tue, 24 Oct 2017 10:07:21 +0200
Message-ID: <1508832441.28673.12.camel@suse.com>
References: <20171018071501.4900-1-drake@endlessm.com>
         <1508319080.8211.2.camel@suse.com>
         <CAD8Lp47eCDkYX8gOQx2YYnt_hubqkmMjZ5U75t9gPSy6B=5MDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD8Lp47eCDkYX8gOQx2YYnt_hubqkmMjZ5U75t9gPSy6B=5MDw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, den 24.10.2017, 12:16 +0800 schrieb Daniel Drake:
> Hi Oliver,
> 
> On Wed, Oct 18, 2017 at 5:31 PM, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org> wrote:
> > 
> > Am Mittwoch, den 18.10.2017, 15:15 +0800 schrieb Daniel Drake:
> > > 
> > > Notes:
> > >     v2:
> > >     - Handle quirk later in suspend, to avoid interfering with other parts
> > >       of the suspend routine.
> > >     - Don't do the disconnect on runtime suspend, only for S3 suspend
> > 
> > well, can we effectively runtime suspend these devices?
> 
> How can I test for effective runtime suspend?

No, I meant, does it make sense to do that?

> > Furthermore, it seems to me that we indeed cannot do a runtime
> > suspend on external devices needing this quirk, but what about
> > internal devices?
> 
> In this case the modem is an internal device.

It seems to me that obviously if you disable a device's port you
cannot support remote wakeup. But I do not see why, if the device
is internal you would want to block runtime suspend, even if
remote wakeup is not necessary.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
