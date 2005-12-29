From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Re: Hotplug events during sleep transition
Date: Thu, 29 Dec 2005 00:20:14 -0500
Message-ID: <200512290020.16246.dtor_core@ameritech.net>
References: <Pine.LNX.4.44L0.0512282108100.3218-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512282108100.3218-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 December 2005 21:10, Alan Stern wrote:
> On Tue, 27 Dec 2005, Dmitry Torokhov wrote:
> 
> > > Would it be possible to simply mark the device as 'removed' and ignore it
> > > until we resumed, and then clean it up (hotplug events and everything)?
> > >
> > 
> > Unfortunately swsusp resumes devices in the middle of suspend process
> > with everything frozen and drivers don't know if they may clean up or
> > have to postpone doing so.
> 
> Drivers should strive to avoid cleaning up after removed devices during 
> their resume methods in any case.  Such cleanups shouldn't happen until 
> userspace has been unfrozen.
> 
> >  To do it uniformly you'd need to introduce
> > threads and offload cleanups. I doubt it is good idea to require each
> > subsystem to define cleanup thread or [ab]used keventd?
> 
> Why do you need a new cleanup thread?  What's wrong with the existing 
> strategy for handling removed devices -- i.e., the procedure that would 
> have been followed if there was no suspend/resume transition?
> 

Sometimes there is no such procedure. For example if you yank PS/2 mouse
there is no way for the system to detect it's missing. Only when you try
to resume and mouse does not respond you realize it's gone. I bet there
are other devices like that. 

-- 
Dmitry
