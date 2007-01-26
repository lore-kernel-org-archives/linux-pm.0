From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] suspend/resume debugging: device filter
Date: Fri, 26 Jan 2007 09:36:43 +0000
Message-ID: <20070126093643.GA4627@ucw.cz>
References: <20070125110501.GA25151@elte.hu> <20070126015536.GA14917@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070126015536.GA14917@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > it might be better to do this centrally in sysfs, via a per-device =

> > attribute, to individually enable suspend and resume on a per device =

> > basis, but my sysfs-fu is not strong enough for that now ;-)
> =

> Here's a (compile tested only) patch that does this on a per-device
> basis, which is smaller, and should work just as well as your patch.
> =

> It creates a new file in the power/ directory for every device called
> "can_suspend".  Write a '0' to it to prevent that device from being
> suspended.

Maybe we could just introduce debug_flags?

> +static ssize_t can_suspend_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t n)
> +{
> +	if (!n)
> +		return -EINVAL;
> +
> +	switch (buf[0]) {
> +	case 'y':
> +	case 'Y':
> +	case '1':
> +		dev->no_suspend =3D 0;
> +		break;
> +	case 'n':
> +	case 'N':
> +	case '0':
> +		dev->no_suspend =3D 1;
> +		break;

default: return -EINVAL ?

							Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
