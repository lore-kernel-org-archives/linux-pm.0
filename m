From: Marcus Better <marcus@better.se>
Subject: Re: Re: 2.6.22-rc1 suspend to RAM problem
Date: Thu, 17 May 2007 19:14:32 +0200
Message-ID: <f2i2ho$l8p$1@sea.gmane.org>
References: <f2evir$8n1$1@sea.gmane.org> <f2f02b$a47$1@sea.gmane.org>
	<200705161534.42740.rjw@sisk.pl>
	<200705171044.26662.marcus@better.se>
	<20070517092809.GA4608@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Sounds so. Try to locate which driver.

Found it! It's fw-ohci. Haven't bisected it yet though.

Marcus
