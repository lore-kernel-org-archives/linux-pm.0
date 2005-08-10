From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Re: PowerOP 0/3: System power operating point
	managementAPI
Date: Wed, 10 Aug 2005 08:35:03 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A501852767@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76398581291642187=="
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
To: Pavel Machek <pavel@ucw.cz>, Todd Poynor <tpoynor@mvista.com>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
List-Id: linux-pm@vger.kernel.org

--===============76398581291642187==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

> > Depending on the ability of the hardware to make software-controlled
> > power/performance adjustments, this may be useful to select custom
> > voltages, bus speeds, etc. in desktop/server systems.  Various
embedded
> > systems have several parameters that can be set.  For example, an
XScale
> > PXA27x could be considered to have six basic power parameters
(mainly
> > cpu run mode and memory and bus dividers) that for the most part
> > should
> 
> This scares me a bit. Is table enough to handle this? I'm afraid that
> table will get very large on systems that allow you to do "almost
> anything".

You have use something abstract enough such that multiple systems can
use it.  If turns out to be big, another more user friendly/generic
layer would probably need to be built atop it.  In a closed system this
table is generally small and just describes a fundamental set of
parameters.


One why which this is handled for an entire system in the DPM case might
be:

You can flexibly create operating point sets in user space which are
appropriate for the underlying platform which the in kernel platform
specific back end knows how to interpret. This list of tuples in theory
might be big, but in practice it is not so large.

Now, to keep higher level user space code from having to understand all
the details of the architecture specific tuple list, DPM allows you to
create states which can be consistent across platforms (if you choose).
Each state will map to that lower architecture specific list.  The
policy manager sets the state to arch specific table list.

States : (fast->c0, mid->c1, slow->c2, idle->c2, off->s1)

Arch table: [["c0", a, b, c, e, f]
		 ["c1", a, b, c, e, f]
             ["c2", a, b, c, e, f]
		 ["t1", a, b, c, e, f]
		 ["t7", a, b, c, e, f]
		 ["s1", a, b, c, e, f]
		 ["s2", a, b, c, e, f]]

Now, how you move from state to state is up to the policy manager.  In
DPM you can set things up such that the kernel scheduler drives state
transitions or if that doesn't make sense you for your system, you can
control the change from else where, this can be from user state or
kernel state.  In any case the state to arch table mapping is done by
the policy manager best in user space.

To have fine grained control you probably need to make state changes at
the kernel level as there are timing realities.  If something a bit
coarser grained if desired it can all be done from user space.

By describing a very simple state diagram which just knows
fast/slow/idle you can potentially save a lot of power.  More elaborate
states can be built but that becomes very application specific. 

It seems Todd's PowerOP idea is a good one in that it allows multiple
mechanisms to be used.  Whether that is the current or evolved CPUFREQ
one, a DPM one, or some other one.

Regards,
Richard Woodruff


--===============76398581291642187==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76398581291642187==--
