From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: PowerOP 0/3: System power operating point management
	API
Date: Wed, 10 Aug 2005 15:02:18 -0700
Message-ID: <42FA796A.4080205@mvista.com>
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com>
	<20050810100718.GC1945@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050810100718.GC1945@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
>>Depending on the ability of the hardware to make software-controlled
>>power/performance adjustments, this may be useful to select custom
>>voltages, bus speeds, etc. in desktop/server systems.  Various embedded
>>systems have several parameters that can be set.  For example, an XScale
>>PXA27x could be considered to have six basic power parameters (mainly
>>cpu run mode and memory and bus dividers) that for the most part
>>should
> 
> 
> This scares me a bit. Is table enough to handle this? I'm afraid that
> table will get very large on systems that allow you to do "almost
> anything".

Exhaustive tables for all combinations of possible parameters aren't 
expected (or practical for many systems as you note).  In practice, a 
subset of these possible operating points are created and activated over 
the lifetime of the system, where the subset is chosen by a system 
designer according to the needs of the particular system.  It's a matter 
for the higher-layer power management software to decide whether to have 
in-kernel tables of the possible operating points (as cpufreq does for 
various platforms) or whether to require userspace to create only the 
ones wanted (as does DPM).  There are cpufreq patches for PXA27x 
somewhere, for example, and in that case a subset of the supported 
operating points (and there are still only about 16 of those even for 
such a complicated piece of hardware) are represented in the kernel 
tables, choosing one of the possible combinations of memory/bus/etc. 
parameters for each unique cpu frequency.  Thanks,

-- 
Todd
