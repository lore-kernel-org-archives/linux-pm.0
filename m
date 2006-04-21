From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: RE: RE: on-ness
Date: Fri, 21 Apr 2006 13:58:56 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD0137BC0B@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============56224547308352735=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============56224547308352735==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

I think Pavel's points are important. Unless we're prepared to expose
exactly the ACPI semantics (and I don't think we are), we need to make
sure that the namespace is not easily confused with ACPI's namespace.

I would also prefer names to numbers, for the reasons already pointed
out - harder to confuse, less likely to be taken as an
arithmetically-interpretable ordered sequence, and easier to insert new
values into actual ordered sequences. 

However, I also have to admit that I like the notion of the zero-state
meaning having a consistent meaning across the different atttributes and
it might be good to have a similarly consistent name for the
maximum/full-operation state across the attributes...

scott

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Pavel Machek
Sent: Thursday, April 20, 2006 8:26 AM
To: Brown, Len
Cc: David Brownell; linux-pm@lists.osdl.org
Subject: Re: [linux-pm] RE: on-ness

Hi!

> (restored linux-pm to cc:)

> no, if the numbers happen to corrolate to ACPI states, that is purely 
> lucky for the ACPI maintainer:-) But honestly, we should "leverage" 
> all we can from ACPI.
> My role, of course, it to make sure that the generic description can 
> accommodate everything ACPI can do.

Please, put there translation layer from the begining. Otherwise people
will assme they *are* ACPI states, and great confusion will begin.

See suspend functions, where half people assumed they are acpi Dx
states, half people thought they are pci Dx states, and half the people
assumed they are system Sx states.


It took quite long to sort out.

> yes, idle refers to either Cx or Dx states -- it depends on the 
> device.  0 means operating, non zero means non-operating.
> 
> Re: strings.
> we breifly debated strings vs numbers.
> I'm not confident that there are enough unique strings available 
> without falling into state0, state1, state2, state3 -- so numbers 
> seemed simpler.
> The only issue I see with numbers is that they imply order, and it may

> be that some operating points might not have such a strict order.

Second issue is that you might want to "insert" between states.

Lets look at disk. Old disks had:

spinning
spindown

states. You'd name them 0 and 1, eventually apps will learn to use that.
But (some) newer disks have

spinning
slowspin
spindown

if app does echo 1 > state, it will get slowspin instead of spindown it
wanted.

Yes, inventing good names may be tricky in some cases, but in other
cases names are very natural (arm has sleep, deep sleep and big sleep,
iirc).... And we can always fall back to state0..state5.

						Pavel
--
Thanks, Sharp!


--===============56224547308352735==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============56224547308352735==--
