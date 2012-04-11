From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 11 Apr 2012 13:06:53 -0400
Message-ID: <1334164013.23924.271.camel@gandalf.stny.rr.com>
References: <20120411165531.GA3717@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120411165531.GA3717-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-04-11 at 22:55 +0600, Andrey Rahmatullin wrote:
> On many ASUS laptops and probably on some non-ASUS ones you need to unload
> ehci_hcd or unbind both USB controllers from it before entering S3, else
> the system will lockup. Here are some links:
> 
> http://thread.gmane.org/gmane.linux.kernel/1222803
> https://bugzilla.kernel.org/show_bug.cgi?id=37632
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=658778
> http://ubuntuforums.org/showthread.php?t=1444822
> 
> This still happens on my K53E on v3.4-rc2-16-ga9e1e53.
> 
> Unbinding just one of two controllers doesn't help.
> 
> Disabling /sys/bus/pci/devices/0000:00:1[ad].0/power/wakeup doesn't help.
> echo mem>/sys/power/state doesn't hang with 'core' in /sys/power/pm_test,
> only with 'none'.
> 
> Windows 7 enters S3 perfectly well.
> 
> I didn't see any other suggestions how to debug this. I can provide any
> debug data if that will help. This seems to be a very important problem
> for owners of certain devices.
> 

Yeah, I never got a real fix. I'm still using the script that removes
the driver and adds it back during the suspend/resume sequence. That
seems to be a working work-around for me.

That said, I would love to have this fixed for real. Not just for me,
but for anyone else that is suffering from the same issue. I'm a kernel
developer and can easily include work arounds like this. But for anyone
else, this is a total fail for Linux in general.

I'm willing to test fixes, as the issue still exists for my laptop if I
remove the script.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
