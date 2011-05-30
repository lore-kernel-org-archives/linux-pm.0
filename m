From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 6/8] x86 idle APM: deprecate
	CONFIG_APM_CPU_IDLE
Date: Mon, 30 May 2011 17:25:26 +0800
Message-ID: <20110530092526.GD11601__48487.2316512794$1306747764$gmane$org@kroah.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
	<99c63221435963e0cee2402686ba99293c2ffa9e.1306662035.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <99c63221435963e0cee2402686ba99293c2ffa9e.1306662035.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, stable@kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Sun, May 29, 2011 at 05:41:48AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> We don't want to export the pm_idle function pointer to modules.
> Currently CONFIG_APM_CPU_IDLE w/ CONFIG_APM_MODULE forces us to.
> 
> CONFIG_APM_CPU_IDLE is of dubious value, it runs only on 32-bit
> uniprocessor laptops that are over 10 years old.  It calls into
> the BIOS during idle, and is known to cause a number of machines
> to fail.
> 
> Removing CONFIG_APM_CPU_IDLE and will allow us to stop exporting
> pm_idle.  Any systems that were calling into the APM BIOS
> at run-time will simply use HLT instead.

Same as the other patch, I'm not going to apply this to a stable tree

greg k-h
