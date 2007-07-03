From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 13:13:13 +0100
Message-ID: <20070703121313.GA21318__22388.254342559$1183465433$gmane$org@srcf.ucam.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707030813.53481.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707030813.53481.oliver@neukum.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2007 at 08:13:53AM +0200, Oliver Neukum wrote:

> Only if you want to audit all character devices' read() and write()
> methods for races against suspend().
> / on fuse is a bad idea.

Any driver that assumes that userspace will be frozen during suspend has 
been broken forever. That behaviour has never been guaranteed.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
