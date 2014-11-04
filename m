From: Ezaul Zillmer <ezaulzillmer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
Date: Tue, 4 Nov 2014 06:09:02 -0800 (PST)
Message-ID: <553e634f-ce75-4409-883c-acbfe773e950@googlegroups.com>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home>
 <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home>
 <20141021191905.GR21108@lukather>
 <20141103210244.1425e0c7@neptune.home>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_268_1275270479.1415110142073"
Return-path: <linux-sunxi+bncBD2ILSOUX4CBB7V34ORAKGQE7YOT2DA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141103210244.1425e0c7-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
List-Id: linux-pm@vger.kernel.org

------=_Part_268_1275270479.1415110142073
Content-Type: text/plain; charset=UTF-8

Hi Bruno

Cubieboard2  + Kernel 3.18-rc3

[   15.955655] axp20x-regulator axp20x-regulator: regulators node not found
[   15.962580] LDO1: 1300 mV
[   15.965732] LDO2: at 3000 mV
[   15.969120] LDO3: at 2275 mV
[   15.972314] LDO4: at 2800 mV
[   15.975700] LDO5: at 2800 mV
[   15.979075] DCDC2: at 1400 mV
[   15.982555] DCDC3: at 1250 mV
[   15.985706] axp20x 0-0034: AXP20X driver loaded

What was missing for axp20x work of cubieboard2 dt? 
as poderiar do to run this drive? 

I thank you!

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_268_1275270479.1415110142073
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Bruno<div><br></div><div>Cubieboard2 &nbsp;+ Kernel 3.1=
8-rc3</div><div><br></div><div>[ &nbsp; 15.955655] axp20x-regulator axp20x-=
regulator: regulators node not found<br></div><div><div><div>[ &nbsp; 15.96=
2580] LDO1: 1300 mV</div><div>[ &nbsp; 15.965732] LDO2: at 3000 mV</div><di=
v>[ &nbsp; 15.969120] LDO3: at 2275 mV</div><div>[ &nbsp; 15.972314] LDO4: =
at 2800 mV</div><div>[ &nbsp; 15.975700] LDO5: at 2800 mV</div><div>[ &nbsp=
; 15.979075] DCDC2: at 1400 mV</div><div>[ &nbsp; 15.982555] DCDC3: at 1250=
 mV</div><div>[ &nbsp; 15.985706] axp20x 0-0034: AXP20X driver loaded</div>=
</div><div><br></div></div><div><div>What was missing for axp20x work of cu=
bieboard2 dt?&nbsp;</div><div>as poderiar do to run this drive?&nbsp;</div>=
<div><br></div><div>I thank you!</div></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_268_1275270479.1415110142073--
