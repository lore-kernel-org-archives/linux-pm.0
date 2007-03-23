From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 09:15:10 -0700
Message-ID: <200703230915.12117.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221655.17693.david-b@pacbell.net>
	<Pine.LNX.4.60.0703230745070.4651@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0703230745070.4651@poirot.grange>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 11:46 pm, Guennadi Liakhovetski wrote:
> On Thu, 22 Mar 2007, David Brownell wrote:
> =

> > So the fundamental definition needs to be in relative terms,
> > because platform-specific differences otherwise make trouble.
> =

> What if we define system-wide and per device power states in terms of =

> time? Time needed for the system / device to become fully operational =

> again? And you'd need a user-space calibration daemon...

So if you take two otherwise identical systems and clock one slower
than the other, then "standby" may become "suspend-to-RAM"?

Yuck.  No.  Speed is only a factor in that STR is likely slower.

- Dave
