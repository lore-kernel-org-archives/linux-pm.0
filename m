From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC PATCH 2/3] PCI: parallel resume for pci devices
	on bus 0
Date: Thu, 18 Dec 2008 23:49:04 -0700
Message-ID: <20081219064903.GP19967__21351.6632481062$1229669516$gmane$org@parisc-linux.org>
References: <1229668453.562.92.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1229668453.562.92.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pci@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 19, 2008 at 02:34:13PM +0800, Zhang Rui wrote:
> +	/* parallel resume for pci devices on bus 0 */
> +	if (dev->bus->number == 0)
> +		device_parallel_resume_register(&dev->dev, 1);

"bus 0" is presumably supposed to mean "devices on a root bus".  I think
you should be checking for dev->bus->parent == NULL instead.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
