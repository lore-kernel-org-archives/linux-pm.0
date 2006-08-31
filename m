From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 15:22:50 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A95886@de01exm64.ds.mot.com>
References: <1157030838.10909.144.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
In-Reply-To: <1157030838.10909.144.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>, ext David Singleton <daviado@gmail.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

> [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Amit Kucheria
> =

> > >
> > > - latency is not an attribute of a certain operating point but a
> > function of
> > > two arguments - current operating point and a point we =

> are goint to =

> > > switch to. Therefor latency just does not belong to =

> 'struct powerop'
> > =

> > I disagree.
> =

> Problem is that you disagree without giving your reasons. =

> Here is another reason putting latency into your operating =

> point definition isn't going to fly:
> =

> http://lwn.net/Articles/196900/ <--- An API for specifying =

> latency constraints
> =

> http://lwn.net/Articles/197282/
---

Actually, the proposed acceptable_latency functions just make it =

more useful to add latency information to the operating point =

definitions. The new interfaces set a [global] acceptable =

latency, the operating point attribute would define the maximum =

latency that could occur for a particular OP or sleep mode. =

You need both sides - you need to know what's an acceptable =

latency and you need to know what latency a particular =

operation (like transitioning to a different OP) will impose; =

then you can decide whether a particular transition can be =

made while still meeting the required latency.

So, if a driver had set acceptable_latency to 300ms, the
Power-Management policy manager could look at the range of
available Ops and pick the lowest-power OP that met the
expected load and would also meet the required latency
guarantee. [And note that the acceptable latency has to include
both the resume time and whatever part of suspend happens with
interrupts blocked and can't be aborted.]

I like this new facility a lot. Now we just need something similar
for expressing anticipated required processing capacity ("I need
n thousand instructions executed in the next s seconds") in a nice
platform-independent way...

Scott
