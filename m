From: Kukjin Kim <kgene@kernel.org>
Subject: RE: [PATCH RESEND v6 1/3] Documentation: dts: Documentation entry to
 explain how to use PWM FAN as a cooling device
Date: Fri, 14 Aug 2015 18:36:47 +0900
Message-ID: <025f01d0d674$bd5c0820$38141860$@kernel.org>
References: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
 <1439298440-15882-1-git-send-email-l.majewski@samsung.com>
 <1439298440-15882-2-git-send-email-l.majewski@samsung.com>
 <55CBE220.1010301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <55CBE220.1010301@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Krzysztof Kozlowski' <k.kozlowski@samsung.com>, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Eduardo Valentin' <edubezval@gmail.com>, 'Kukjin Kim' <kgene@kernel.org>
Cc: 'Linux PM list' <linux-pm@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 'Lukasz Majewski' <l.majewski@majess.pl>
List-Id: linux-pm@vger.kernel.org

Krzysztof Kozlowski wrote:
> On 11.08.2015 22:07, Lukasz Majewski wrote:
> > Explanation of several properties, which allow PWM fan working as a cooling
> > device, have been embraced in this commit.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Acked-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  .../devicetree/bindings/hwmon/pwm-fan.txt          | 29 ++++++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> >
> 
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> I'll take care of it and send it to Kukjin for v4.4.
> 
Hi, Krzysztof

If you're ok, I'll take this series into samsung tree directly for v4.3.

Thanks,
Kukjin
