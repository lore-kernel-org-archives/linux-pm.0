From: Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH 1/5] Thermal: do bind operation after thermal zone or
 cooling device register returns.
Date: Sun, 21 Oct 2012 12:05:24 +0200
Message-ID: <5083C8E4.7090007@gmail.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com> <1350387889-15324-2-git-send-email-hongbo.zhang@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63342 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab2JUKDb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Oct 2012 06:03:31 -0400
In-Reply-To: <1350387889-15324-2-git-send-email-hongbo.zhang@linaro.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "hongbo.zhang" <hongbo.zhang@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, linaro-kernel@lists.linaro.org, "hongbo.zhang" <hongbo.zhang@linaro.com>, patches@linaro.org, amit.kachhap@linaro.org

Hi,

On 10/16/2012 01:44 PM, hongbo.zhang wrote:
> From: "hongbo.zhang" <hongbo.zhang@linaro.com>
> 
> In the previous bind function, cdev->get_max_state(cdev, &max_state) is called
> before the registration function finishes, but at this moment, the parameter
> cdev at thermal driver layer isn't ready--it will get ready only after its
> registration, so the the get_max_state callback cannot tell the max_state
> according to the cdev input.
> This problem can be fixed by separating the bind operation out of registration
> and doing it when registration completely finished.

When thermal_cooling_device_register() is called, the thermal framework
assumes the cooling device is "ready", i.e. all of its ops callbacks
return meaningful results. If the cooling device is not ready at this
point, then this is a bug in the code that registers it.
Specifically, the faulty code in your case is in the cpufreq cooling
implementation, where the cooling device is registered before being
added to the internal list of cpufreq cooling devices. So, IMHO the fix
is needed there.

--
Francesco
