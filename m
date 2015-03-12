From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 05/22] PM / AVS: SmartReflex: %pF is only for function pointers
Date: Thu, 12 Mar 2015 11:09:26 -0700
Message-ID: <7hy4n2w0ix.fsf@deeprootsystems.com>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com>
	<1426130037-17956-5-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426130037-17956-5-git-send-email-scottwood@freescale.com>
	(Scott Wood's message of "Wed, 11 Mar 2015 22:13:40 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

Scott Wood <scottwood@freescale.com> writes:

> Use %pS for actual addresses, otherwise you'll get bad output
> on arches like ppc64 where %pF expects a function descriptor.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
