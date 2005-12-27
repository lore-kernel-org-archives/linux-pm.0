From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Tue, 27 Dec 2005 23:05:33 +0100
Message-ID: <20051227220533.GA1914@elf.ucw.cz>
References: <20051227213439.GA1884@elf.ucw.cz>
	<d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26812517187801532=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: dtor_core@ameritech.net
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============26812517187801532==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >  static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
> >  {
> > -       return sprintf(buf, "%u\n", dev->power.power_state.event);
> > +       if (dev->power.power_state.event)
> > +               return sprintf(buf, "suspend\n");
> > +       else
> > +               return sprintf(buf, "on\n");
> >  }
> 
> Are you sure that having only 2 options (suspend/on) is enough at the
> core level? I could envision having more levels, like "poweroff", etc?

Note that interface is 0/2, currently, so this is improvement :-).

One day, when we find device that needs it, we may want to add more
states. I don't know about such device currently.

								Pavel
-- 
Thanks, Sharp!

--===============26812517187801532==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26812517187801532==--
