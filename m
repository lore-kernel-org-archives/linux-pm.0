From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] why do we need run disk sync before entering	S3
Date: Thu, 14 May 2009 22:00:56 -0300
Message-ID: <20090515010055.GB21718__36945.3940810219$1242349346$gmane$org@khazad-dum.debian.net>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<200905131616.27334.rjw@sisk.pl> <20090514094249.GG6417@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090514094249.GG6417@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 14 May 2009, Pavel Machek wrote:
> But remember there are even in-kernel s2ram triggers, for example on
> zaurus when battery goes critical.

Are there?  I am quite interested on this!

Are they safe on x86?

thinkpad-acpi receives some critical alarms from the firmware, for which the
recommended action by the vendor is to go into S3 immediately.  There is
also one which requires S4 as the recommended damage control measure.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
