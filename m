From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power
 regression
Date: Thu, 19 Dec 2013 16:45:57 +0100
Message-ID: <20131219154557.GC26289@pd.tnic>
References: <baff264285f6e585df757d58b17788feabc68918.1387403066.git.len.brown@intel.com>
 <20131219122257.GC11279@gmail.com>
 <ad600986-5506-4cf5-baad-d767079d086f@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad600986-5506-4cf5-baad-d767079d086f@email.android.com>
Sender: stable-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Mike Galbraith <efault@gmx.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 19, 2013 at 06:40:41AM -0800, H. Peter Anvin wrote:
> ... or just use static_cpu_has() maybe?

Right, if we can get the compiler to generate the shortest CLFLUSH of 3
bytes with register indirect addressing for the operand, then stomping
over those 3 bytes with the alternatives would be the fastest solution.

If, of course, three NOPs which get discarded in the front end are
cheaper than the near JMP from static_cpu_has.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
