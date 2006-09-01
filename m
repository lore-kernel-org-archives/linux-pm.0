From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 1 Sep 2006 09:49:06 -0500 (CDT)
Message-ID: <200609011449.k81En6YD025595@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Amit Kucheria's message of Fri, 01 Sep 2006 11:11:36 +0300
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: amit.kucheria@nokia.com
Cc: linux-pm@lists.osdl.org, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

| From Amit.Kucheria@nokia.com Fri Sep  1 03:14:57 2006
| =

| On Thu, 2006-08-31 at 15:22 -0400, ext Preece Scott-PREECE wrote:
| ...
| > So, if a driver had set acceptable_latency to 300ms, the
| > Power-Management policy manager could look at the range of
| > available Ops and pick the lowest-power OP that met the
| > expected load and would also meet the required latency
| > guarantee. [And note that the acceptable latency has to include
| > both the resume time and whatever part of suspend happens with
| > interrupts blocked and can't be aborted.]
| =

| Thinking of it that way, latency is possibly useful. Needs more
| thinking. But what latency values are associated with the OP? The values
| from the spec sheet provided by the silicon vendor do not take into
| account the other operations necessary before you can safely switch to a
| new OP. Some of these operations require indeterminate amount of time.
---

That's something the system designer would have to work out and provide
as part of the information associated with each possible OP transtion
(that is, it would potentially be different for each (currentOP, newOP)
pair).

The system designer would also need to decide whether the latencies had
to be worst-case guarantees or whether the system could tolerate
occasionally missing a latency deadline. This would vary depending on
the system (a heart pacemaker might find deadlines to be more important
than a PDA).

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
