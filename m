From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtl8187 usb wifi adaptor causes suspend hang
Date: Wed, 31 Dec 2008 13:33:13 -0600
Message-ID: <495BC8F9.4040203__42962.577721528$1230910639$gmane$org@lwfinger.net>
References: <348894.23448.qm@web23108.mail.ird.yahoo.com>
	<495B82CB.6050205@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <495B82CB.6050205@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Bob Copeland <me@bobcopeland.com>, USB list <linux-usb@vger.kernel.org>, linux-wireless@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, htl10@users.sourceforge.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan Jenkins wrote:
> Hin-Tak Leung wrote:
>> --- On Tue, 30/12/08, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>   
>>> Alan Jenkins wrote:
>>>     
>>>> That won't fix hibernation though.  The disconnect
>>>>       
>>> method can still get
>>>     
>>>> called in resume from hibernation, before the
>>>>       
>>> workqueue gets unfrozen. 
>>>     
>>>> To be honest, I'm far more interested in
>>>>       
>>> suspend-to-disk than
>>>     
>>>> suspend-to-ram.
>>>>       
>>> Does this patch fix your problem? It works here, but I only
>>> did one
>>> test. The patch is for wireless-testing.
>>>
>>> Larry
>>>     
>> My test is that STD works alright, but STR still does not work. I haven't tried STD for a long time - I mostly use STR with SUSPEND_MODULES -, so I have no idea if STD works before the patch or not. With the patch, I can suspend to RAM (removing my SUSPEND_MODULES workaround temporarily), but it would not "defrost - this is similiar to  my failed attempt at fixing this - adding some skeleton _suspend()/_resume() routines can get the driver to STR, but it won't defrost. Without any _suspend()/_resume() routines, it won't even suspend, but just spend ages trying to suspend.
>>
>> I'll post your patch to http://bugzilla.kernel.org/show_bug.cgi?id=11887  as a work-in-progress...
>>
>> Hin-Tak
> 
> Thanks for the patch.  I tested STD too, and it doesn't seem to hang
> anymore.  I even tested removing the adaptor while the system was
> hibernated.  However, after resume the interface is useless.
> 
> I get a kernel error message, which repeats regularly (something like
> every 5 or 10 seconds):
> 
>     phy0: Reset timeout!
> 
> and it doesn't work:
> 
>     # iwlist wlan0 scan
>     wlan0     Interface doesn't support scanning : Network is down
> 
>     # ifconfig wlan0 up
>     SIOCSIFFLAGS: Connection timed out
> 
> I have to re-plug the adaptor, and then it works again.

Thanks for testing. I have some ideas on how to improve the
suspend/resume, but they will require some changes in the structure. I
will also try to determine why my system fails at STR so I can test
both flavors.

Larry
