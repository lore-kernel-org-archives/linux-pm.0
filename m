From: Michael Buesch <mb@bu3sch.de>
Subject: Re: b43_suspend problem
Date: Tue, 22 Jan 2008 16:53:18 +0100
Message-ID: <200801221653.18897.mb__30186.6699512631$1201017388$gmane$org@bu3sch.de>
References: <Pine.LNX.4.44L0.0801131634380.28667-100000@netrider.rowland.org>
	<200801211605.10446.mb@bu3sch.de> <200801220036.46505.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801220036.46505.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday 22 January 2008 00:36:45 Rafael J. Wysocki wrote:
> > I still don't like this function wrapping.
> > I'm pretty sure the additional parameter to the function is not
> > needed. We can check dev->suspend_in_progress to find out
> > if we are in a up/down or in a suspend/resume cycle.
> 
> You're right, I overlooked that.
[snip]

The patch looks good. Did you try it on b43 hardware?

-- 
Greetings Michael.
