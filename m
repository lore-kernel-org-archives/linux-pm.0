From: Amit Kucheria <amit.kucheria@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 01 Sep 2006 11:11:36 +0300
Message-ID: <1157098297.5389.3.camel@localhost>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A95886@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A95886@de01exm64.ds.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Preece Scott-PREECE <scott.preece@motorola.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-08-31 at 15:22 -0400, ext Preece Scott-PREECE wrote:
> > [mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Amit Kucheria
> > =

> > > >
> > > > - latency is not an attribute of a certain operating point but a
> > > function of
> > > > two arguments - current operating point and a point we =

> > are goint to =

> > > > switch to. Therefor latency just does not belong to =

> > 'struct powerop'
> > > =

> > > I disagree.
> > =

> > Problem is that you disagree without giving your reasons. =

> > Here is another reason putting latency into your operating =

> > point definition isn't going to fly:
> > =

> > http://lwn.net/Articles/196900/ <--- An API for specifying =

> > latency constraints
> > =

> > http://lwn.net/Articles/197282/
> ---

<snip>

> So, if a driver had set acceptable_latency to 300ms, the
> Power-Management policy manager could look at the range of
> available Ops and pick the lowest-power OP that met the
> expected load and would also meet the required latency
> guarantee. [And note that the acceptable latency has to include
> both the resume time and whatever part of suspend happens with
> interrupts blocked and can't be aborted.]

Thinking of it that way, latency is possibly useful. Needs more
thinking. But what latency values are associated with the OP? The values
from the spec sheet provided by the silicon vendor do not take into
account the other operations necessary before you can safely switch to a
new OP. Some of these operations require indeterminate amount of time.

> I like this new facility a lot. Now we just need something similar
> for expressing anticipated required processing capacity ("I need
> n thousand instructions executed in the next s seconds") in a nice
> platform-independent way...

bogomips? :-D

-- =

Amit Kucheria <amit.kucheria@nokia.com>
Nokia
