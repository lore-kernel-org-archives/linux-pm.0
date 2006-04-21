From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 12:00:45 -0700
Message-ID: <200604211200.45959.david-b@pacbell.net>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<200604211130.05650.david-b@pacbell.net>
	<20060421183340.GA3071@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80756848751159027=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060421183340.GA3071@isilmar.linta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============80756848751159027==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > Well, "on" could have one defined meaning.  Maybe it's the only option
> > available, until drivers add intelligence.  I don't see any problem
> > with the other names being system-specific, since it's rather unlikely
> > that a PCI_D3hot state will ever appear on most embedded ARM boxes.
> > And if any userspace code tries to set power states, it had darn well
> > better understand exactly what's going on.
> 
> Yes. However if a network managing userspace code wants to set the power
> conusmption of a WLAN device to the lowest possible setting, it shouldn't
> need a configuration file specific for each platform.

The current wireless extensions have power management calls, and I'd
expect that whatever replaces them would do so as well.  Which brings
out a point I've made before:  userspace power management should not as
a rule be driven through /sys/devices/... files, but instead as part
of the normal API to the devices.  That's the best way to ensure that
the operations fit into the devices' usage models, rather than as an
ill-fitting frankenstein bolt-on.  ;)


> > That seems too complicated to me.  When debugging, I want to visualize the
> > entire tree ... so I'd want a /sys/kernel/debug/clocktree file, with lots
> > of system-specific information.  (Which gate bits are set/cleared?  What
> > speeds? etc.)  Or else I just want to know which state the driver is in,
> > like "mostly one".  Some of that is taste, but also don't forget that each
> > attribute in sysfs has a cost.
> 
> Uh, there's a rule "one-value-per-file" for sysfs. Arrays might be OK in
> certain cases, but lots of system-specific information in one file? No way,
> IMHO.

Remember that sysfs != debugfs, and /sys/kernel/debug is debugfs.  Debugfs
explicitly allows seq_printf() and friends.   (And for that matter, binary
data in sysfs is more than one-value-per-file ... there are plenty of cases
where that "rule" doesn't need to be obeyed.)

- Dave




--===============80756848751159027==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80756848751159027==--
