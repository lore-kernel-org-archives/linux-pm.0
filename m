From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 1/2] cpufreq: ondemand: allow custom
 powersave_bias_target handler to be registered
Date: Tue, 2 Apr 2013 21:24:17 +0200
Message-ID: <20130402192417.GD17675@pd.tnic>
References: <1364926304-1799-1-git-send-email-jacob.shin@amd.com>
 <1364926304-1799-2-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1364926304-1799-2-git-send-email-jacob.shin@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Renninger <trenn@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 02, 2013 at 01:11:43PM -0500, Jacob Shin wrote:
> This allows for another [arch specific] driver to hook into existing
> powersave bias function of the ondemand governor. i.e. This allows AMD
> specific powersave bias function (in a separate AMD specific driver)
> to aid ondemand governor's frequency transition deicisions.
> 
> Signed-off-by: Jacob Shin <jacob.shin@amd.com>

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
