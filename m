From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] dt-bindings: hwmon (pwm-fan) Remove dead
 "cooling-*-state" properties
Date: Tue, 19 Mar 2019 16:27:51 +0100
Message-ID: <14253588.EKW5T2lhLl@diego>
References: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, krzk@kernel.org, jonathanh@nvidia.com, kgene@kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, linux@roeck-us.net
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 19. M=E4rz 2019, 15:54:04 CET schrieb Robin Murphy:
> The old "cooling-{min,max}-state" properties for thermal bindings were
> ratified to "cooling-{min,max}-level" by commit eb168b70dea5 ("of:
> thermal: Fix inconsitency between cooling-*-state and cooling-*-level"),
> which were later removed entirely by commit e04907dbc259 ("dt-bindings:
> thermal: Remove "cooling-{min|max}-level" properties").
> =

> The pwm-fan binding, however, was apparently in-flight in parallel with
> that ratification, and so managed to introduce an example of the old
> properties which escaped the scope of the later cleanup and has thus
> continued to be dutifully copied for new boards despite being useless.
> Clean up these remaining undocumented anachronisms to minimise any
> further confusion.
> =

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> =

> Presented as one big hwmon patch for simplicity, but the DT changes
> can quite easily be broken out by platform if maintainers prefer.

For the Rockchip-parts
Acked-by: Heiko Stuebner <heiko@sntech.de>
