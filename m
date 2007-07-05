From: "Scott Preece" <sepreece@gmail.com>
Subject: Re: Power event notification patch
Date: Thu, 5 Jul 2007 08:56:58 -0500
Message-ID: <7b69d1470707050656q45f7cad7g38e9695a176569d1@mail.gmail.com>
References: <67670A5CEA5C374B8E7B16D7DC55F95301247453@bgsmsx413.gar.corp.intel.com>
	<1183642080.3818.46.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183642080.3818.46.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 7/5/07, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2007-07-05 at 18:47 +0530, V, Sankara Narayanan wrote:
> > We have to confirm that. And even if that does, running just linux
> > kernel as OS without these applications/libraries does not guarantee the
> > power notification.
>
> True.
>
> > It means that I have to run these apps/libraries
> > wherever I want power event notification (example embedded devices).
>
> Well, if you have a truly embedded device then likely you don't care
> about this at all since the applications will work together much closer
> than on a desktop system. Also, you likely have much stricter
> requirements in that each application *must* be able to do exactly steps
> 1/2/3 before the system is suspended. Also, suspend will likely be
> *much* faster too.
>
> If it's pseudo-embedded like Nokia's N770/800 then you can very well run
> things like hal to handle it.
>
> johannes
--

On most embedded devices, power-management does not involve user
action. In many devices the actions are all initiated in the kernel,
in others they are *enabled* in userspace and carried out n the kernel
(some people argue that responsiveness requires that it be there,
others that it's policy and belongs in user space). In any case, the
kernel usually needs to do some steps that may or may not allow the
system to go to sleep (for instance, asking devices to suspend, which
they are allowed to reject).

I tend to think that the kernel is the only place where a notice can
be sent out only if the system is going to sleep.

However, there's a paradox there. The kernel doesn't know it can go to
sleep until the devices have suspended, which means that apps could be
notified but would have to option to save state anyway, since they
would have no devices to write it to.

In any case, I haven't heard a really convincing argument for
notifications to apps. If you have a real NEED for apps to be able to
save state, then you need a mechanism that allows them to reject the
event until they're safe...

-- 
scott preece
