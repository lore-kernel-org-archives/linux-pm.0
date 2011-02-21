From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] amba: move to pm ops
Date: Mon, 21 Feb 2011 13:06:59 +0530
Message-ID: <AANLkTinFpX_uRzrVN+ZpuOLyM-QJovyK14Lb5bQSdTwh__42093.2226851166$1298273916$gmane$org@mail.gmail.com>
References: <1297928986-31171-1-git-send-email-rabin.vincent@stericsson.com>
	<s5hr5b6wo7z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s5hr5b6wo7z.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 17, 2011 at 23:14, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 17 Feb 2011 13:19:46 +0530,
> Rabin Vincent wrote:
>>
>> Support pm_ops in the AMBA bus instead of the legacy ops. =A0 pm_ops is =
needed
>> for runtime pm, and there is also a general move to convert drivers to
>> dev_pm_ops rather than bus specific PM ops in order to facilitate core
>> development.
>>
>> Since there are only 6 AMBA drivers using suspend/resume, convert them a=
ll in
>> one go and directly use the GENERIC_SUBSYS_PM_OPS in the bus.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Greg Kroah-Hartman <gregkh@suse.de>
>> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
>
> For sound/arm/aaci.c,
>
> =A0Acked-by: Takashi Iwai <tiwai@suse.de>
>
> Though, this would result in a zero-filled *_pm struct when
> CONFIG_PM_* isn't set? =A0It's a few bytes wastes ;)

Thank you for the ack.  However, in v2 of the patch I've done a
different implementation in the bus code that doesn't necessitate
the conversion of all the drivers together, so this part is
dropped.  I will take this comment into consideration if I do
end up converting all the drivers.  Thanks.
