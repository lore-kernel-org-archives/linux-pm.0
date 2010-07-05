From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: About run time power management in linux
Date: Mon, 5 Jul 2010 09:51:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1007050947290.568-100000@netrider.rowland.org>
References: <BLU102-W532408CF4DA1EA7664EDAEBB10@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BLU102-W532408CF4DA1EA7664EDAEBB10@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 5 Jul 2010, Raj Kumar wrote:

> 
> Hi Alan,
> 
>  
> 
> I have few more questions about run time power management:
> 
>  
> 
> 1) Please correct me if i am wrong. If there is a bus driver that is managing various power domains,
> 
> and suppose this domain has some child devices. 
> 
>  
> 
> Then child has to inform run time Power management core i am idle and i want to go to get suspended,

Strictly speaking, the child device doesn't do this -- its driver does.

> then run time pm core will notify the bus driver of child and then bus driver calls the corresponding child's
> 
>  
> 
> suspend. right?

Right.  In fact, that's true even when the bus driver manages only a 
single power domain.

> 2) run time power management can be done at device "type" and "class". But what does mean of this device
> 
> type. what use cases are defined for run time power management for device "type"?

Here are a couple of examples.  In the USB subsystem there are two
"types": devices and interfaces.  In the SCSI subsystem there are three
"types": hosts, targets, and LUNs.  Each type generally needs to do 
runtime power management differently.

Alan Stern
