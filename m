From: Ezaul Zillmer <ezaulzillmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
Date: Wed, 5 Nov 2014 04:29:27 -0800 (PST)
Message-ID: <83f27c8b-1971-4c7b-b709-479c91dc0fda@googlegroups.com>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home>
 <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
 <20141021191905.GR21108@lukather>
 <20141103210244.1425e0c7@neptune.home>
 <553e634f-ce75-4409-883c-acbfe773e950@googlegroups.com>
 <20141104222124.1bc7e6ec@neptune.home>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4140_1276766978.1415190567636"
Return-path: <linux-sunxi+bncBD2ILSOUX4CBBKFQ5CRAKGQELIS6P7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141104222124.1bc7e6ec-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: ezaulzillmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
List-Id: linux-pm@vger.kernel.org

------=_Part_4140_1276766978.1415190567636
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



*Hello Bruno Thank you for your attention sought some more docs just=20
applying a patch and here is the result.*

*add*

*https://dev.openwrt.org/browser/trunk/target/linux/sunxi/patches-3.14/210-=
mfd-add-axp20x-pmic-driver.patch?rev=3D42463*

*https://dev.openwrt.org/browser/trunk/target/linux/sunxi/patches-3.14/211-=
input-add-axp20x-power-enable-key-support.patch?rev=3D42463*

*https://dev.openwrt.org/browser/trunk/target/linux/sunxi/patches-3.14/213-=
dt-sunxi-add-x-powers.patch?rev=3D42463*

*https://dev.openwrt.org/browser/trunk/target/linux/sunxi/patches-3.14/214-=
1-dt-sun7i-add-axp209-to-cubieboard2.patch?rev=3D42463*

*[   15.962628] i2c /dev entries driver*
*[   15.975115] input: axp20x-pek as=20
/devices/soc@01c00000/1c2ac00.i2c/i2c-0/0-0034/axp20x-pek/input/input0*
*[   15.985426] LDO1: 1300 mV*
*[   15.988789] LDO2: 1800 <--> 3300 mV at 3000 mV*
*[   15.993788] LDO3: 700 <--> 3500 mV at 2275 mV*
*[   15.998416] LDO4: 1250 <--> 3300 mV at 2800 mV*
*[   16.003440] LDO5: 1800 <--> 3300 mV at 2800 mV*
*[   16.008406] DCDC2: 700 <--> 2275 mV at 1400 mV*
*[   16.013377] DCDC3: 700 <--> 3500 mV at 1250 mV*
*[   16.018005] axp20x 0-0034: AXP20X driver loaded*

Thank=C2=B4s=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_4140_1276766978.1415190567636
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><b><div>Hello Bruno&nbsp;</div><div><br></div><div>Th=
ank you for your attention sought some more docs just applying a patch&nbsp=
;</div><div>and here is the result.</div></b></div><div><b><br></b></div><d=
iv><b>add</b></div><div><b>https://dev.openwrt.org/browser/trunk/target/lin=
ux/sunxi/patches-3.14/210-mfd-add-axp20x-pmic-driver.patch?rev=3D42463<br><=
/b></div><div><b>https://dev.openwrt.org/browser/trunk/target/linux/sunxi/p=
atches-3.14/211-input-add-axp20x-power-enable-key-support.patch?rev=3D42463=
<br></b></div><div><b>https://dev.openwrt.org/browser/trunk/target/linux/su=
nxi/patches-3.14/213-dt-sunxi-add-x-powers.patch?rev=3D42463<br></b></div><=
div><b>https://dev.openwrt.org/browser/trunk/target/linux/sunxi/patches-3.1=
4/214-1-dt-sun7i-add-axp209-to-cubieboard2.patch?rev=3D42463<br></b></div><=
div><b><br></b></div><div><b>[ &nbsp; 15.962628] i2c /dev entries driver</b=
></div><div><b>[ &nbsp; 15.975115] input: axp20x-pek as /devices/soc@01c000=
00/1c2ac00.i2c/i2c-0/0-0034/axp20x-pek/input/input0</b></div><div><b>[ &nbs=
p; 15.985426] LDO1: 1300 mV</b></div><div><b>[ &nbsp; 15.988789] LDO2: 1800=
 &lt;--&gt; 3300 mV at 3000 mV</b></div><div><b>[ &nbsp; 15.993788] LDO3: 7=
00 &lt;--&gt; 3500 mV at 2275 mV</b></div><div><b>[ &nbsp; 15.998416] LDO4:=
 1250 &lt;--&gt; 3300 mV at 2800 mV</b></div><div><b>[ &nbsp; 16.003440] LD=
O5: 1800 &lt;--&gt; 3300 mV at 2800 mV</b></div><div><b>[ &nbsp; 16.008406]=
 DCDC2: 700 &lt;--&gt; 2275 mV at 1400 mV</b></div><div><b>[ &nbsp; 16.0133=
77] DCDC3: 700 &lt;--&gt; 3500 mV at 1250 mV</b></div><div><b>[ &nbsp; 16.0=
18005] axp20x 0-0034: AXP20X driver loaded</b></div><div><br></div><div>Tha=
nk=C2=B4s&nbsp;</div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_4140_1276766978.1415190567636--
