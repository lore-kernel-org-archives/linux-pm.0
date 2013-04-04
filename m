From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V4 0/2] cpufreq: ondemand: add AMD specific powersave bias
Date: Thu, 04 Apr 2013 18:42:41 +0200
Message-ID: <2097539.ScIVCEFJgr@skinner.arch.suse.de>
References: <1365092344-11310-1-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365092344-11310-1-git-send-email-jacob.shin@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 04, 2013 11:19:02 AM Jacob Shin wrote:
> This patchset adds AMD specific powersave bias function to the ondemand
> governor; which can be used to help ondemand governor make more power
> conscious frequency change decisions based on feedback from hardware
> (availble on AMD Family 16h and above).

Either the one way:
  1) Documenting powersave_bias and add the stuff there, best with a default
      set so that the stuff gets used
or
  2) Marking powersave_bias deprecated and embed things into ondemand
      directly

should be fine.

As you give this some usefulness now and it's going to get
used (automatically) and the stuff is even documented, I cannot suggest
anything anymore how to integrate that better.

Acked-by: Thomas Renninger <trenn@suse.de>
