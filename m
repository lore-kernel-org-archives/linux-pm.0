From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Wed, 8 Feb 2006 23:25:32 +0100
Message-ID: <20060208222532.GA4824@titan.lahn.de>
References: <20060208125753.GA25562@srcf.ucam.org> <20060208130422.GB25659@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060208130422.GB25659@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

On Wed, Feb 08, 2006 at 01:04:22PM +0000, Matthew Garrett wrote:
> diff --git a/include/linux/pm.h b/include/linux/pm.h
...
> +void pm_set_ac_status(int (*ac_status_function)(void))
> +{
> +	down(&pm_sem);
> +	get_ac_status = ac_status_function;
> +	up(&pm_sem);
> +}

Why do you need a semaphore/mutex, when you only do one assignment,
which is atomic by itself?

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
