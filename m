From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
	driver for select intel processors
Date: Sun, 30 May 2010 11:20:02 +0200
Message-ID: <87zkzhzqyl.fsf__24445.5899614424$1275211389$gmane$org@basil.nowhere.org>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
	<20100526204426.fd2be7e0.akpm@linux-foundation.org>
	<alpine.LFD.2.00.1005272354100.24823@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005272354100.24823@localhost.localdomain> (Len
	Brown's message of "Thu\, 27 May 2010 23\:57\:42 -0400 \(EDT\)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Len Brown <lenb@kernel.org> writes:

>> ... What happens when an additional CPU is brought online? 
>> It melts?  ;)
>
> With the current driver, processors hot-added after modprobe
> will use C1 only, and not use deeper C-states.

I agree with Andrew that it will likely not be a lot of 
effort to restructure the driver to handle cpu hotplug
properly, and it's better done from the beginning.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
