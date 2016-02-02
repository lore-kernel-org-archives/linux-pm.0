From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Restore device name
Date: Tue, 2 Feb 2016 14:27:57 +0200
Message-ID: <56B0A0CD.70003@gmail.com>
References: <1454415319-31380-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454415319-31380-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: pali.rohar@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sorry, I've sent an incomplete patch, ignore that, will re-send the full 
version

On  2.02.2016 14:15, Ivaylo Dimitrov wrote:
> Patch <703df6c097956d17a818e63961c82e8e9eef9fef> ("power: bq27xxx_battery:
>   Reorganize I2C into a module") has removed the device name numbering from
> bq27xxx_battery_i2c_probe. Fix that by restoring the code.
>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/power/bq27xxx_battery_i2c.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
