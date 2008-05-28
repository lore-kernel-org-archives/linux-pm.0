From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/2] kexec jump -v10: save/restore device
	state
Date: Wed, 28 May 2008 08:57:42 -0400
Message-ID: <20080528125742.GA3884__43907.1169625551$1211979669$gmane$org@redhat.com>
References: <1211449099.12819.15.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1211449099.12819.15.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 22, 2008 at 05:38:19PM +0800, Huang, Ying wrote:

[..]
> Known issues:
> 
> - Can not work with the new devices hibernation operations in
>   2.6.26-rc2-mm1 so far. Working on this now.
> 
> - APIC is not put into legacy mode during kexec, so kexec may failed
>   (no IRQ) if APIC is not put into legacy mode.
> 
> - The suspend/resume callback of device drivers are used to put
>   devices into quiescent state. This will unnecessarily (possibly
>   harmfully) put devices into low power state. This is intended to be
>   solved by separating device quiesce/unquiesce callback from the
>   device suspend/resume callback.
> 
> - Because the segment number supported by sys_kexec_load is limited,
>   hibernation image with many segments may not be load. This is
>   planned to be eliminated by adding a new flag to sys_kexec_load to
>   make a image can be loaded with multiple sys_kexec_load invoking.
> 
> 

These two patches look good to me. I think once you have worked out
issues with IOAPIC and generated patches for compatibility with
new suspend/resume callbacks, these patches are good enough to get
some testing going on in -mm tree.

I will also test out -v10 very soon.

Thanks
Vivek
