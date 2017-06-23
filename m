From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] thermal: bcm2835: Fix error code in
 'bcm2835_thermal_probe'
Date: Fri, 23 Jun 2017 22:25:45 +0200 (CEST)
Message-ID: <1667598657.325840.1498249545131@email.1und1.de>
References: <20170623194435.8094-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170623194435.8094-1-christophe.jaillet@wanadoo.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, rjui@broadcom.com, sbranden@broadcom.com, kernel@martin.sperl.org, rafal@milecki.pl, eric@anholt.net, rui.zhang@intel.com, bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com, edubezval@gmail.com
Cc: linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> Christophe JAILLET <christophe.jaillet@wanadoo.fr> hat am 23. Juni 2017 um 21:44 geschrieben:
> 
> 
> 'tz' is a valid pointer at this point, so calling PTR_ERR on it is
> pointless.
> This 'err = PTR_ERR(tz)' looks like a cut'n'paste from a few lines above.
> So remove it. 'err' is already the error we want to report.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, but Dan Carpenter already send a fix for this.
