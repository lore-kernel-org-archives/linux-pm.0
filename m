From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 07:46:31 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0703230745070.4651@poirot.grange>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221556.08948.david-b@pacbell.net>
	<200703230021.04470.rjw@sisk.pl>
	<200703221655.17693.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221655.17693.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Mar 2007, David Brownell wrote:

> So the fundamental definition needs to be in relative terms,
> because platform-specific differences otherwise make trouble.

What if we define system-wide and per device power states in terms of =

time? Time needed for the system / device to become fully operational =

again? And you'd need a user-space calibration daemon...

Thanks
---
Guennadi Liakhovetski
