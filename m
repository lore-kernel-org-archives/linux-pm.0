From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 12/15] OMAP4: powerdomain data: add wake-up
	latency figures
Date: Tue, 16 Aug 2011 16:38:42 +0200
Message-ID: <CAORVsuUtJ05AHrT0C3rUg_2iUH=NfKdWpqqzoEZms9pYXR6u6A__28165.7976600856$1313505575$gmane$org@mail.gmail.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
	<1313502198-9298-13-git-send-email-j-pihet@ti.com>
	<4E4A7E25.8020701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E4A7E25.8020701@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 16, 2011 at 4:26 PM, Santosh <santosh.shilimkar@ti.com> wrote:
> On Tuesday 16 August 2011 07:13 PM, jean.pihet@newoldbits.com wrote:
>>
>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> This patch adds wake up latency numbers for OMAP4. Note that these are
>> preliminary numbers and need to be relooked.
>>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> The INACTIVE state is added as unsupported.
>>
> In that case, don't add that support in first place. When INA support is
> getting added, you can update these as well.
No. A value is needed for all states, even if unsupported at the
moment. Omitting a value causes it to be set to '0', which means 'no
latency'.

Jean
