From: Peter Chen <peter.chen@nxp.com>
Subject: RE: [PATCH 2/7] arm: mach-shmobile: pm-rmobile: add missing
 of_node_put after calling of_parse_phandle
Date: Mon, 4 Jul 2016 02:10:04 +0000
Message-ID: <HE1PR04MB14504D0A5905A777452DC57D8B380@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-3-git-send-email-peter.chen@nxp.com>
 <CAMuHMdVE8VzPunLzr7WO-kzcg25rKvFkoQcjJ4czwrQxX_obiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdVE8VzPunLzr7WO-kzcg25rKvFkoQcjJ4czwrQxX_obiw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

 
>On Fri, Jul 1, 2016 at 11:41 AM, Peter Chen <peter.chen@nxp.com> wrote:
>> of_node_put needs to be called when the device node which is got from
>> of_parse_phandle has finished using.
>>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
>
>NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>> --- a/arch/arm/mach-shmobile/pm-rmobile.c
>> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
>> @@ -209,6 +209,7 @@ static void __init add_special_pd(struct device_node *np,
>enum pd_types type)
>>         special_pds[num_special_pds].pd = pd;
>
>The pd pointer is stored in the line above, and released later in put_special_pds().
>
>>         special_pds[num_special_pds].type = type;
>>         num_special_pds++;
>> +       of_node_put(pd);
>
>Hence it must not be released here, as that would cause a double release when
>put_special_pds() is executed.
>

Thanks, Geert, it is my careless.

Please forget this patch.

Peter
