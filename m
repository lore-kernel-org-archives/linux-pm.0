From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 23:47:01 +0200
Message-ID: <200707032347.01936.oliver__26045.460967771$1183499597$gmane$org@neukum.org>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707032337.52544.rjw@sisk.pl>
	<20070703213639.GA29149@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703213639.GA29149@srcf.ucam.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Matthew Garrett:
> On Tue, Jul 03, 2007 at 11:37:51PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, 3 July 2007 23:20, Matthew Garrett wrote:
> > > We're used to the idea of applications blocking when a resource they're 
> > > using goes away - NFS has done it forever. 
> > 
> > Now, please tell me how many driver writers even thought that something
> > might try to access their devices after .suspend() had been executed (or
> > even whilie it was being executed)?
> 
> Every single driver that fails under those conditions is already broken, 
> and has been forever. It's likely that they're broken under run-time 
> suspend, too.

There _is_ no runtime syspend in working condition. The interface
to do that has been scheduled for removal.

	Oliver
