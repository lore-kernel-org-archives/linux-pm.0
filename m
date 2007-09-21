From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Sat, 22 Sep 2007 09:47:56 +1000
Message-ID: <200709220947.58872.nigel__38178.7165454172$1190418569$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<878x6z67n8.fsf@jbms.ath.cx>
	<BF08447B-234F-4851-89BF-92A57EA801C6@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BF08447B-234F-4851-89BF-92A57EA801C6@mac.com>
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
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi.

On Saturday 22 September 2007 09:19:18 Kyle Moffett wrote:
> I think that in order for this to work, there would need to be some  
> ABI whereby the resume-ing kernel can pass its entire ACPI state and  
> a bunch of other ACPI-related device details to the resume-ed kernel,  
> which I believe it does not do at the moment.  I believe that what  
> causes problems is the ACPI state data that the kernel stores is  
> *different* between identical sequential boots, especially when you  
> add/remove/replace batteries, AC, etc.

That's certainly possible. We already pass a very small amount of data between 
the boot and resuming kernels at the moment, and it's done quite simply - by 
putting the variables we want to 'transfer' in a nosave page/section. I could 
conceive of a scheme wherein this was extended for driver data. Since the 
memory needed would depend on the drivers loaded, it would probably require 
that the space be allocated when hibernating, and the locations of structures 
be stored in the image header and then drivers notified of the locations to 
use when preparing to resume, but it could work...
 
> Since we currently throw away most of that in-kernel ACPI interpreter  
> state data when we load the to-be-resumed image and replace it with  
> the state from the previous boot it looks to the ACPI code and  
> firmware like our system's hardware magically changed behind its  
> back.  The result is that the ACPI and firmware code is justifiably  
> confused (although probably it should be more idempotent to begin  
> with).  There's 2 potential solutions:
>    1) Formalize and copy a *lot* of ACPI state from the resume-ing  
> kernel to the resume-ed kernel.
>    2) Properly call the ACPI S4 methods in the proper order

... that said, I don't think the above should be necessary in most cases. I 
believe we're already calling the ACPI S4 methods in the proper order. If I 
understood correctly, Rafael put a lot of effort into learning what that was, 
and into ensuring it does get done.
 
> Neither one is particularly easy or particularly pleasant, especially  
> given all the vendor bugs in this general area.  Theoretically we  
> should be able to do both, since one will be more reliable than the  
> other on different systems depending on what kinds of firmware bugs  
> they have.

Regards,

Nigel
