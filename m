From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 14:46:32 +0100
Message-ID: <20070705134632.GA22177__34501.8789791085$1183643489$gmane$org@srcf.ucam.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<E1I6Pud-0000V1-00@dorka.pomaz.szeredi.hu>
	<200707051523.44826.rjw@sisk.pl>
	<200707051528.34754.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707051528.34754.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 05, 2007 at 03:28:33PM +0200, Oliver Neukum wrote:

> If, at a minimum, we can determine that we can STD without a freezer.
> It makes no sense to invest a lot of work to face the same problem
> again with STD.

I have a model for STD that avoids the need to freeze the entirity of 
userspace, but I need to find some more time to flesh it out.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
