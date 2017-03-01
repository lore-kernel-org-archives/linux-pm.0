From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 24/44] x86: intel-family.h: Add GEMINI_LAKE SOC
Date: Thu, 2 Mar 2017 01:48:00 +0200
Message-ID: <CAHp75Vcv_B=Od9isbH_d-eMWJ7zf3myTG1Hdj-dFzAKFE6mUVg@mail.gmail.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
 <20170301052748.27810-1-lenb@kernel.org> <311f77708f362c1af0a999ba5ebbbc062fdc5601.1488345270.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <311f77708f362c1af0a999ba5ebbbc062fdc5601.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 1, 2017 at 7:27 AM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>

> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -59,6 +59,7 @@
>  #define INTEL_FAM6_ATOM_MERRIFIELD     0x4A /* Tangier */
>  #define INTEL_FAM6_ATOM_MOOREFIELD     0x5A /* Anniedale */
>  #define INTEL_FAM6_ATOM_GOLDMONT       0x5C
> +#define INTEL_FAM6_ATOM_GEMINI_LAKE    0x7A
>  #define INTEL_FAM6_ATOM_DENVERTON      0x5F /* Goldmont Microserver */

One nit: can we keep it in order by model ID?

-- 
With Best Regards,
Andy Shevchenko
