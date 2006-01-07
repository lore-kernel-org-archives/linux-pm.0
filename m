From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch] pm: fix runtime powermanagement's
	/sys	interface
Date: Sat, 7 Jan 2006 00:47:52 -0500
Message-ID: <20060107054752.GA3184@neo.rr.com>
References: <20060105221334.GA925@isilmar.linta.de>
	<20060105222338.GG2095@elf.ucw.cz>
	<20060105222705.GA12242@isilmar.linta.de>
	<20060105230849.GN2095@elf.ucw.cz>
	<20060105234629.GA7298@isilmar.linta.de>
	<20060105235838.GC3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net>
	<20060106001252.GE3339@elf.ucw.cz>
	<Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
	<20060106085920.GI3339@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67302486913420656=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060106085920.GI3339@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============67302486913420656==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2006 at 09:59:21AM +0100, Pavel Machek wrote:
> On ??t 05-01-06 17:37:30, Patrick Mochel wrote:
> > +static ssize_t pm_possible_states_show(struct device * d,
> > +				       struct device_attribute * a,
> > +				       char * buffer)
> > +{
> > +	struct pci_dev * dev = to_pci_dev(d);
> > +	char * s = buffer;
> > +
> > +	s += sprintf(s, "d0");
> > +	if (dev->poss_states[PCI_D1])
> > +		s += sprintf(s, " d1");
> > +	if (dev->poss_states[PCI_D2])
> > +		s += sprintf(s, " d2");
> > +	if (dev->poss_states[PCI_D3hot])
> > +		s += sprintf(s, " d3");
> 
> Could we use same states as rest of code, i.e. "D2" instead of "d2"
> and "D3hot" instead of "d3"?

"D3hot" and "D3cold" most likely going to be removed and replaced with just
"D3" in my next set of changes.  Although this distinction is mentioned in
the spec, d3cold cannot actually be specified.  Rather, D3cold is entered when
the parent bridge is powered off.

Thanks,
Adam


--===============67302486913420656==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67302486913420656==--
