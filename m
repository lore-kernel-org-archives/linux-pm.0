From: andrew-sh.cheng <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH 3/3] devfreq: add mediatek cci devfreq
Date: Mon, 11 Feb 2019 21:21:47 +0800
Message-ID: <1549891307.12454.4.camel@mtksdaap41>
References: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
 <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <CGME20190129063600epcas2p255b062c64f22555692ff895634ea4eb0@epcms1p4>
 <20190129081750epcms1p41e46de569005622ad3d90f9aaa75f545@epcms1p4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190129081750epcms1p41e46de569005622ad3d90f9aaa75f545@epcms1p4>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "fan.chen@mediatek.com" <fan.chen@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2019-01-29 at 17:17 +0900, MyungJoo Ham wrote:
> >From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> >
> >For big/little cpu cluster architecture,
> >not only CPU frequency, but CCI frequency will also affect performance.
> >
> >Little cores and cci share the same buck in Mediatek mt8183 IC,
> >so we add a CCI devfreq which will get notification when buck voltage
> >is changed, then CCI devfreq can set cci frequency as high as possible.
> >
> >Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> 
> Please correct the coding style first in the .c file.
> 
> - empty last line?
I will modify this in next patch
> - inconsistent indentation (line26? match the first lines for all variable declarations OR don't match them at all)
I will modify this in next patch
> - Need proper boilerplate and try to comply with C89.
I have checked my compile is gnu89 and without build warning.
May you advice where I should modify, or script I can use to check?
> 
> Cheers,
> MyungJoo
> 
