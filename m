From: shrybman <shrybman@teksavvy.com>
Subject: Re: [PATCH/RFT 0/2] regression fix: "smpboot: do_boot_cpu failed(-1) to wakeup CPU#1"
Date: Fri, 16 Oct 2015 02:12:35 -0400
Message-ID: <9b933cf01de22ee9248bf2146df96cc4@teksavvy.com>
References: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dparsons@brightdsl.net, x86@kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

> Shane, Donald,
> Please test this pair of patches.
> 
> If the default kernel still has a problem booting CPU #1 on yoru Core2 system,
> "cpu_init_udelay=10000" should get you back to the legacy delays.


I tried with both patches and it worked fine without cpu_init_udelay.


Thanks,


Shane
