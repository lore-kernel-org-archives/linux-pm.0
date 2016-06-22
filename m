From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] cpufreq: s5pv210: use relaxed IO accesors
Date: Wed, 22 Jun 2016 14:04:41 +0200
Message-ID: <CAJKOXPcywVya133jsz5_5mE8j4M3L6+orcWPPrStpNshcj+JsA@mail.gmail.com>
References: <1466588198-27445-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466588198-27445-2-git-send-email-ben.dooks@codethink.co.uk>
 <20160622093820.GE5458@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160622093820.GE5458@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 22, 2016 at 11:38 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-06-16, 10:36, Ben Dooks wrote:
>> The use of __raw IO accesors is not endian safe and should be used
>> sparingly. The relaxed variants should be as lightweight and also
>> are endian safe.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> ---
>>  drivers/cpufreq/s5pv210-cpufreq.c | 68 +++++++++++++++++++--------------------
>>  1 file changed, 34 insertions(+), 34 deletions(-)
>
> For both patches:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied for v4.8, thanks.

When resending the cpufreq-exynos please CC me as well.

Best regards,
Krzysztof
