From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 09:36:33 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0512270935350.2357@shark.he.net>
References: <Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0512261744260.10595-100000@netrider.rowland.org>
	<20051227172950.GH1822@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============040214353422932891=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051227172950.GH1822@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============040214353422932891==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 27 Dec 2005, Pavel Machek wrote:

> On Po 26-12-05 17:47:23, Alan Stern wrote:
> > On Mon, 26 Dec 2005, Patrick Mochel wrote:
>
> > > To that effect, the per-device power file and its semantics should go away
> > > completely and replaced with something that supports this new API.
> >
> > Allow me to direct your attention to this posting:
> >
> > http://lists.osdl.org/pipermail/linux-pm/2005-September/001421.html
> >
> > and the follow-on messages.  They implement exactly the type of API you're
> > talking about.  When I have some time available I will rework the patches,
> > with improvements as suggested by the discussions on the mailing list, and
> > submit them.
>
> Ok, what about this as a first step? It unbreaks the interface between
> kernel and user, and allows something like patches above to be taken
> in future, without userland changes.
> 								Pavel
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -33,15 +33,12 @@ static ssize_t state_show(struct device
>  static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
>  {
>  	pm_message_t state;
> -	char * rest;
> -	int error = 0;
> +	int error = -EINVAL;
>
> -	state.event = simple_strtoul(buf, &rest, 10);
> -	if (*rest)
> -		return -EINVAL;
> -	if (state.event)
> +	state.event = PM_EVENT_SUSPEND;
> +	if ((n == 2) && !strncmp(buf, "on", min(n, 2)))
>  		error = dpm_runtime_suspend(dev, state);
> -	else
> +	if ((n == 7) && !strncmp(buf, "suspend", min(n, 7)))
>  		dpm_runtime_resume(dev);
>  	return error ? error : n;
>  }

You can drop the min(n, 2 or 7) since n == 2 or 7.

-- 
~Randy

--===============040214353422932891==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============040214353422932891==--
