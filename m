From: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Subject: Re: wait_for_completion_interruptible does not wait !!
	[During PM suspend]
Date: Sun, 20 Jun 2010 00:42:02 -0700
Message-ID: <AANLkTik5x38mWno0EUGhaHDD_INLlpeaGSExGxjIC4as__1815.36034583605$1277019789$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 20, 2010 at 12:23 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
> On 06/20/2010 08:52 AM, Suresh Rajashekara wrote:
>> The ioctl waits on a completion variable (using
>> wait_for_completion_interruptible).
> ...
>> I tried wait_for_completion instead, but now the kernel refuses to suspend.
>
> Do you check return value of wait_for_completion_interruptible and
> return its value if nonzero?
>
> We need the code to comment, otherwise it's hard to say.

No. I am not checking the return value of the
wait_for_completion_interruptible. I can do it

The code is as follows. I have cut the relevant portion of the code
and pasted in to the email

My test application. The actual application is exactly similar (actual
application has different names)
<SNIP>
void *headset_detect_thread_start ( void *private_date )
{
    int hs_fd = 0;
    int iState = 0;

    hs_fd = open("/dev/adc", O_RDWR);

    if ( hs_fd == -1 ) {
        printf("The headset device could not be opened\n");
        goto hs_thread_exit;
    }

    for (;;) {
       pthread_testcancel();
       ioctl(hs_fd, IOCTL_CODEC_HEADSET_DETECT, &iState);
       pthread_testcancel();

       if ( iState )
           printf("\n++++ Headset Insertion detected\n");
       else
           printf("\n---- Headset Removal detected\n");

       SignalEvent(); // Dummy function, but the actual application
does inside the function
    }

hs_thread_out:
    close(hs_fd);
hs_thread_exit:
    pthread_exit(NULL);
}
</SNIP>


Kernel Code:

/* Code from Ioctl of the codec driver*/
<SNIP>
 case IOCTL_CODEC_HEADSET_DETECT:
       headset_detect();
       headset_detect_state = get_hsdetect_state();
       copy_to_user( argp, &headset_detect_state, sizeof(int)) ;
       break;
</SNIP>

implementation of headset_detect in the codec driver
<SNIP>
void headset_detect(void){
	/* This variable is completed in interrupt handler */
    wait_for_completion_interruptible(&drv_priv->headset_completion);
}
</SNIP>

Thanks,
Suresh
