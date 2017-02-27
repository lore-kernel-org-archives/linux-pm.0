From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH] PM / AVS: rockchip-io: add io selectors and
 supplies for rk3328
Date: Mon, 27 Feb 2017 14:26:03 +0100
Message-ID: <5273870.ds1UUp6ZfE@aspire.rjw.lan>
References: <1487853191-10994-1-git-send-email-david.wu@rock-chips.com>
 <m2innw39on.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <m2innw39on.fsf@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: nm@ti.com, huangtao@rock-chips.com, heiko@sntech.de, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sunday, February 26, 2017 01:48:40 PM Kevin Hilman wrote:
> David Wu <david.wu@rock-chips.com> writes:
> 
> > From: "david.wu" <david.wu@rock-chips.com>
> >
> > This adds the necessary data for handling io voltage domains on the rk3328.
> > As interesting tidbit, the rk3328 only contains one iodomain area in the
> > regular General Register Files (GRF).
> >
> > Signed-off-by: david.wu <david.wu@rock-chips.com>
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> Rafael, feel free to take directly.  I don't currently have any other
> AVS stuff in the queue.

I'll queue it up for 4.12 then.

Thanks,
Rafael
