From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / AVS: rockchip-io: Fix module autoload for OF platform driver
Date: Thu, 15 Oct 2015 02:35:39 +0200
Message-ID: <3694102.oARWiAFOaH@vostro.rjw.lan>
References: <1443796077-24722-1-git-send-email-luisbg@osg.samsung.com> <7hlhb8djv1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48572 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753258AbbJOAG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 20:06:56 -0400
In-Reply-To: <7hlhb8djv1.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Luis de Bethencourt <luisbg@osg.samsung.com>, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, nm@ti.com, heiko@sntech.de, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

On Monday, October 12, 2015 11:25:54 AM Kevin Hilman wrote:
> Luis de Bethencourt <luisbg@osg.samsung.com> writes:
> 
> > This platform driver has a OF device ID table but the OF module
> > alias information is not created so module autoloading won't work.
> >
> > Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> Rafael, feel free to apply directly.

Done.

Thanks,
Rafael

