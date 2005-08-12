From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: PowerOP 2/3: Intel Centrino support
Date: Fri, 12 Aug 2005 16:13:28 -0700
Message-ID: <42FD2D18.6080302@mvista.com>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
	<20050810100133.GA1945@elf.ucw.cz>
	<20050810125848.GM852@poupinou.org>
	<20050810184445.GB14350@redhat.com> <42FA8FC0.5000700@mvista.com>
	<20050811150650.GG26524@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050811150650.GG26524@cosmic.amd.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Bruno Ducrot <ducrot@poupinou.org>, Pavel Machek <pavel@ucw.cz>, cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Jordan Crouse wrote:

> When it comes
> to embedded power management concepts, a consistant theme is that people
> often question the usefulness, redundancy or complexity of a solution.  This
> is perfectly understandable, since such a huge majority of the power
> management experts and users are concentrating intently on x86 desktops and
> servers.  

It also occurs to me that another reason for the disconnect between x86 
desktop/server and embedded on this point is the lack of ACPI.  We want 
to do things analogous to the power management performed by ACPI, but 
entirely in Linux, so we need to expose some of those low-level machine 
resources to our power management software.  In many cases those power 
management decisions do not revolve around the question of the MHz at 
which the CPU is to run.  Embedded Linux system power management exists 
for many of the same reasons ACPI exists.


-- 
Todd
