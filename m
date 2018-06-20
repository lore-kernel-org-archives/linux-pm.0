From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Date: Wed, 20 Jun 2018 10:41:42 -0700
Message-ID: <20180620174142.GA76265@gmail.com>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Theodore Ts'o <tytso@mit.edu>, Stephan Mueller <smueller@chronox.de>, Denis Kenzior <denkenz@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Chen,

On Wed, Jun 20, 2018 at 05:40:51PM +0800, Chen Yu wrote:
> crypto_hibernate is a user-space utility to generate
> 512bits AES key and pass it to the kernel via ioctl
> for hibernation encryption.(We can also add the key
> into kernel via keyctl if necessary, but currently
> using ioctl seems to be more straightforward as we
> need both the key and salt transit).
> 
> The key derivation is based on a simplified implementation
> of PBKDF2[1] in e2fsprogs - both the key length and the hash
> bytes are the same - 512bits. crypto_hibernate will firstly
> probe the user for passphrase and get salt from kernel, then
> uses them to generate a 512bits AES key based on PBKDF2.

What is a "512bits AES key"?  Do you mean AES-256-XTS (which takes a 512-bit
key, which the XTS mode internally splits into two keys)?  Do you allow for
other algorithms, or is it hardcoded to AES-256-XTS?  What if someone wants to
use a different algorithm?

BTW, it's difficult to review this with only patch 3/3 Cc'ed to me, as there is
no context about the problem you are trying to solve and what your actual
proposed kernel changes are.  I suggest Cc'ing linux-crypto on all 3 patches.

A few more comments below, from a very brief reading of the code:

[...]
> +
> +#define PBKDF2_ITERATIONS          0xFFFF
> +#define SHA512_BLOCKSIZE 128
> +#define SHA512_LENGTH 64
> +#define SALT_BYTES	16
> +#define SYM_KEY_BYTES SHA512_LENGTH
> +#define TOTAL_USER_INFO_LEN	(SALT_BYTES+SYM_KEY_BYTES)
> +#define MAX_PASSPHRASE_SIZE	1024
> +
> +struct hibernation_crypto_keys {
> +	char derived_key[SYM_KEY_BYTES];
> +	char salt[SALT_BYTES];
> +	bool valid;
> +};
> +
> +struct hibernation_crypto_keys hib_keys;
> +
> +static char *get_key_ptr(void)
> +{
> +	return hib_keys.derived_key;
> +}
> +
> +static char *get_salt_ptr(void)
> +{
> +	return hib_keys.salt;
> +}
[...]
> +
> +
> +#define HIBERNATE_SALT_READ      _IOW('C', 3, struct hibernation_crypto_keys)
> +#define HIBERNATE_KEY_WRITE     _IOW('C', 4, struct hibernation_crypto_keys)

Why are the ioctl numbers defined based on the size of 'struct
hibernation_crypto_keys'?  It's not a UAPI structure, right?

> +
> +static void get_passphrase(char *passphrase, int len)
> +{
> +	char *p;
> +	struct termios current_settings;
> +
> +	assert(len > 0);
> +	disable_echo(&current_settings);
> +	p = fgets(passphrase, len, stdin);
> +	tcsetattr(0, TCSANOW, &current_settings);
> +	printf("\n");
> +	if (!p) {
> +		printf("Aborting.\n");
> +		exit(1);
> +	}
> +	p = strrchr(passphrase, '\n');
> +	if (!p)
> +		p = passphrase + len - 1;
> +	*p = '\0';
> +}
> +
> +#define CRYPTO_FILE	"/dev/crypto_hibernate"
> +
> +static int write_keys(void)
> +{
> +	int fd;
> +
> +	fd = open(CRYPTO_FILE, O_RDWR);
> +	if (fd < 0) {
> +		printf("Cannot open device file...\n");
> +		return -EINVAL;
> +	}
> +	ioctl(fd, HIBERNATE_KEY_WRITE, get_key_ptr());
> +	return 0;

No error checking on the ioctl?

Also, how is the kernel supposed to know how long the key is, and which
algorithm it's supposed to be used for?  I assume it's hardcoded to AES-256-XTS?
What if someone wants to use a different algorithm?

> +}
> +
> +static int read_salt(void)
> +{
> +	int fd;
> +
> +	fd = open(CRYPTO_FILE, O_RDWR);
> +	if (fd < 0) {
> +		printf("Cannot open device file...\n");
> +		return -EINVAL;
> +	}
> +	ioctl(fd, HIBERNATE_SALT_READ, get_salt_ptr());
> +	return 0;
> +}

No error checking on the ioctl?

> +int main(int argc, char *argv[])
> +{
> +	int opt, option_index = 0;
> +	char in_passphrase[MAX_PASSPHRASE_SIZE];
> +
> +	while ((opt = getopt_long_only(argc, argv, "+p:s:h",
> +				NULL, &option_index)) != -1) {
> +		switch (opt) {
> +		case 'p':
> +			{
> +				char *p = optarg;
> +
> +				if (strlen(p) >= (MAX_PASSPHRASE_SIZE - 1)) {
> +					printf("Please provide passphrase less than %d bytes.\n",
> +						MAX_PASSPHRASE_SIZE);
> +					exit(1);
> +				}
> +				strcpy(in_passphrase, p);

I haven't read this super closely, but this really looks like an off-by-one
error.  It seems you intended MAX_PASSPHRASE_SIZE to include a null terminator,
so the correct check would be 'strlen(p) >= MAX_PASSPHRASE_SIZE'.

> +			}
> +			break;
> +		case 's':
> +			{
> +				char *p = optarg;
> +
> +				if (strlen(p) != (SALT_BYTES - 1)) {
> +					printf("Please provide salt with len less than %d bytes.\n",
> +						SALT_BYTES);
> +					exit(1);
> +				}
> +				strcpy(get_salt_ptr(), p);
> +			}
> +			break;

Salts don't need to be human-readable.  How about making the salt binary?  So, a
salt specified on the command-line would be hex.

Eric
