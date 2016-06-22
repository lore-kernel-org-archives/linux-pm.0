From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
Date: Wed, 22 Jun 2016 10:37:42 +0100
Message-ID: <2513e267-5bec-1aef-a222-785903f3789d@codethink.co.uk>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160622093552.GD5458@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160622093552.GD5458@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@lists.codethink.co.uk, linux-samsung-soc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22/06/16 10:35, Viresh Kumar wrote:
> On 22-06-16, 10:33, Ben Dooks wrote:
>> The use of __raw IO accesors is not endian safe and should be used
>> sparingly. The relaxed variants should be as lightweight and also
>> are endian safe.
> 
> I am not sure if exynos's code is required to be endian safe at all or
> not, but this change wouldn't harm as well.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

It is better for any of the ARMv7 and later to do this. We've been
fixing some of the exynos and other code to be endian safe.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
