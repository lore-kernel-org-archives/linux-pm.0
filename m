From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 00/12] CPU idle for Armada XP
Date: Fri, 13 Sep 2013 13:38:10 +0200
Message-ID: <20130913113810.GK19363@lunn.ch>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <20130913110043.GJ19363@lunn.ch>
 <5232F43D.4040404@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5232F43D.4040404@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Ike Pan <ike.pan@canonical.com>, Atsushi Yamagata <yamagata@plathome.co.jp>, Nadav Haklai <nadavh@marvell.com>, David Marlin <dmarlin@redhat.com>, Yehuda Yitschak <yehuday@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Dan Frazier <dann.frazier@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Eran Ben-Avi <benavi@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Leif Lindholm <leif.lindholm@arm.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tomonori Kimura <kimura@plathome.co.jp>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Jon Masters <jcm@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Hironobu Shibata <h-shibata@plathome.co.jp>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazz>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 13, 2013 at 01:17:17PM +0200, Gregory CLEMENT wrote:
> On 13/09/2013 13:00, Andrew Lunn wrote:
> > 
> > On Fri, Sep 13, 2013 at 12:06:29PM +0200, Gregory CLEMENT wrote:
> >> Hello,
> >>
> >> This patch set adds the CPU idle support for Armada XP and prepares
> >> the support for Armada 370. This was based on the work of Nadav
> >> Haklai.
> > 
> > Hi Gregory.
> > 
> > Kirkwood has the ability to put the DDR into self refresh mode, which
> > is used as part of the second level idle mode. Does 370/XP have this?
> 
> Indeed there is a self refresh bit on a DDR related register. I thought
> this kind of feature is more likely used for suspend to ram.

The kirkwood data sheet suggests it is useful if the CPU is idle for a
few milliseconds. So it sounds like it is a slow transition, but does
seem to save a bit of power. I guess in a NO_HZ system, it would make
sense.

	Andrew
