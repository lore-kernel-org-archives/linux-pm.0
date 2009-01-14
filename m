From: "=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=" <arve@android.com>
Subject: Re: [PATCH 02/11] PM: Add early suspend api.
Date: Wed, 14 Jan 2009 15:18:26 -0800
Message-ID: <d6200be20901141518s43dc421ay60f75779fb489559@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231896476-22445-3-git-send-email-arve@android.com>
	<1231924678.7229.278.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1231924678.7229.278.camel@nigel-laptop>
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
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 14, 2009 at 1:17 AM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
>> +
>> +/* The early_suspend structure defines suspend and resume hooks to be c=
alled
>> + * when the user visible sleep state of the system changes, and a level=
 to
>> + * control the order. They can be used to turn off the screen and input
>> + * devices that are not used for wakeup.
>> + * Suspend handlers are called in low to high level order, resume handl=
ers are
>> + * called in the opposite order. If, when calling register_early_suspen=
d,
>> + * the suspend handlers have already been called without a matching cal=
l to the
>> + * resume handlers, the suspend handler will be called directly from
>> + * register_early_suspend. This direct call can violate the normal leve=
l order.
>> + */
>
> Registering can happen while we're suspending and resuming? That
> potential variation in ordering sounds dangerous as far as opportunities
> for race conditions goes.
>

Yes, but there is no time limit on how long the system is in the early
suspend state. This direct call at least allows a driver to rely on
suspend being called before resume.

>> +struct early_suspend {
>> +#ifdef CONFIG_HAS_EARLYSUSPEND
>> +     struct list_head link;
>> +     int level;
>> +     void (*suspend)(struct early_suspend *h);
>> +     void (*resume)(struct early_suspend *h);
>
> Could these functions ever potentially fail in way that you'd want
> callers to know? If so, you might want a non void return value.
>

They are not allowed to fail. These calls inform drivers that the user
visible sleep state has changed.

-- =

Arve Hj=F8nnev=E5g
