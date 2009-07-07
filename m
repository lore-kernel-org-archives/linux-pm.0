From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.30-rc1: touchpad disabled on hibernation
Date: Tue, 7 Jul 2009 02:05:46 +0200
Message-ID: <200907070205.48165.rjw__31663.8186727234$1246925365$gmane$org@sisk.pl>
References: <4A438BA7.9010800@tuffmail.co.uk> <200907070040.14796.rjw@sisk.pl>
	<4A528EE5.5090901@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A528EE5.5090901@gawab.com>
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
To: Justin Madru <jdm64@gawab.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-kernel <linux-kernel@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Kernel Testers List <kernel-testers@vger.kernel.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 07 July 2009, Justin Madru wrote:
> Rafael J. Wysocki wrote:
> > On Thursday 25 June 2009, Alan Jenkins wrote:
> >   
> >> Maciej Rutecki wrote:
> >>     
> >>> 2009/6/25 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:
> >>>   
> >>>       
> >>>> The synaptics touchpad on my EeePC 701 dies on hibernation.  2.6.30 was
> >>>> fine, and it doesn't happen on suspend to ram either.  There are no
> >>>> obvious error messages, but maybe this boot message is relevant:
> >>>>
> >>>> Platform driver 'i8042' needs updating, please use dev_pm_ops
> >>>>
> >>>>     
> >>>>         
> >>> Similar on s2disk, HP/Compaq notebook. Try reload psmouse module. I
> >>> reported it, but nobody answer.
> >>>   
> >>>       
> >> That works, thanks.
> >>     
> >
> > Alan, Maciej, can you both try the patch at
> > http://patchwork.kernel.org/patch/34075/, please?
> >
> > Rafael
> >
> >   
> I've been having the same issue (laptop touchpad not working after resume).
> Your patch seams to fix the problem. I no longer have to reload the 
> psmouse module after resume.

Thanks for testing.

Best,
Rafael
